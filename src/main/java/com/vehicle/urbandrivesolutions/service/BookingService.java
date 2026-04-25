package com.vehicle.urbandrivesolutions.service;

import com.vehicle.urbandrivesolutions.dao.BookingDAO;
import com.vehicle.urbandrivesolutions.dao.PaymentDAO;
import com.vehicle.urbandrivesolutions.entity.Booking;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    /**
     * Cancels a booking owned by userId, applying a calendar-day-based policy:
     *
     *  2+ days before pickup date  →  0%   → REFUNDED
     *  1 day before pickup date    → 20%   → PARTIALLY_REFUNDED
     *  On the pickup date itself   → 50%   → PARTIALLY_REFUNDED
     *  After pickup date           → 100%  → NON_REFUNDABLE
     *
     *  PENDING bookings (not yet paid) always get 0% / REFUNDED.
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
            cancellationFee = BigDecimal.ZERO;
            paymentStatus = "CANCELLED"; // never paid — nothing to refund
        } else {
            LocalDate pickupDate = booking.getPickupDate();
            LocalDate today = LocalDate.now();
            long daysUntilPickup = ChronoUnit.DAYS.between(today, pickupDate);

            BigDecimal total = booking.getTotalAmount();

            if (daysUntilPickup >= 2) {
                // 2 or more days before pickup — full refund
                cancellationFee = BigDecimal.ZERO;
                paymentStatus = "REFUNDED";
            } else if (daysUntilPickup == 1) {
                // The day before pickup — 20% fee
                cancellationFee = total.multiply(new BigDecimal("0.20"))
                        .setScale(2, RoundingMode.HALF_UP);
                paymentStatus = "PARTIALLY_REFUNDED";
            } else if (daysUntilPickup == 0) {
                // Same day as pickup — 50% fee
                cancellationFee = total.multiply(new BigDecimal("0.50"))
                        .setScale(2, RoundingMode.HALF_UP);
                paymentStatus = "PARTIALLY_REFUNDED";
            } else {
                // Pickup date has passed — non-refundable
                cancellationFee = total;
                paymentStatus = "NON_REFUNDABLE";
            }
        }

        bookingDAO.updateCancellationStatus(bookingId, cancellationFee);
        paymentDAO.updatePaymentRefundStatus(bookingId, paymentStatus);
    }
}
