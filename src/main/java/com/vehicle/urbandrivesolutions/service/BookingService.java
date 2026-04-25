package com.vehicle.urbandrivesolutions.service;

import com.vehicle.urbandrivesolutions.dao.BookingDAO;
import com.vehicle.urbandrivesolutions.dao.PaymentDAO;
import com.vehicle.urbandrivesolutions.entity.Booking;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    /**
     * Cancels a booking owned by userId, applying the professional
     * time-based cancellation policy:
     *
     *  > 48 h before pickup  →  0 % fee   → REFUNDED
     *  24 – 48 h before      → 20 % fee   → PARTIALLY_REFUNDED
     *  < 24 h but before     → 50 % fee   → PARTIALLY_REFUNDED
     *  After pickup time     → 100 % fee  → NON_REFUNDABLE
     *
     *  PENDING bookings (not yet paid) always get 0 % / REFUNDED.
     */
    public void cancelBooking(int bookingId, int userId) {

        Booking booking = bookingDAO.getBookingById(bookingId, userId);

        if (booking == null) {
            throw new RuntimeException("Booking not found or does not belong to your account.");
        }

        String currentStatus = booking.getBookingStatus();

        if (!"PENDING".equalsIgnoreCase(currentStatus) && !"CONFIRMED".equalsIgnoreCase(currentStatus)) {
            throw new RuntimeException("Only PENDING or CONFIRMED bookings can be cancelled.");
        }

        BigDecimal cancellationFee;
        String paymentStatus;

        if ("PENDING".equalsIgnoreCase(currentStatus)) {
            // No payment has been collected — cancel with zero fee
            cancellationFee = BigDecimal.ZERO;
            paymentStatus = "REFUNDED";
        } else {
            // CONFIRMED — payment was made, apply time-based policy
            LocalDate pickupDate = booking.getPickupDate();
            LocalDateTime now = LocalDateTime.now();
            // Treat pickup as the very start of that day (00:00)
            LocalDateTime pickupDateTime = pickupDate.atStartOfDay();
            long hoursUntilPickup = ChronoUnit.HOURS.between(now, pickupDateTime);

            BigDecimal total = booking.getTotalAmount();

            if (hoursUntilPickup > 48) {
                cancellationFee = BigDecimal.ZERO;
                paymentStatus = "REFUNDED";
            } else if (hoursUntilPickup > 24) {
                cancellationFee = total.multiply(new BigDecimal("0.20"))
                        .setScale(2, RoundingMode.HALF_UP);
                paymentStatus = "PARTIALLY_REFUNDED";
            } else if (hoursUntilPickup > 0) {
                cancellationFee = total.multiply(new BigDecimal("0.50"))
                        .setScale(2, RoundingMode.HALF_UP);
                paymentStatus = "PARTIALLY_REFUNDED";
            } else {
                // Pickup time has already passed
                cancellationFee = total;
                paymentStatus = "NON_REFUNDABLE";
            }
        }

        bookingDAO.updateCancellationStatus(bookingId, cancellationFee);
        paymentDAO.updatePaymentRefundStatus(bookingId, paymentStatus);
    }
}
