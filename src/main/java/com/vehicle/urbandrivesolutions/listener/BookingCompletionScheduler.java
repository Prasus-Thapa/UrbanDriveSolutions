package com.vehicle.urbandrivesolutions.listener;

import com.vehicle.urbandrivesolutions.dao.BookingDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.temporal.ChronoUnit;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebListener
public class BookingCompletionScheduler implements ServletContextListener {

    private static final Logger log = Logger.getLogger(BookingCompletionScheduler.class.getName());

    private ScheduledExecutorService scheduler;
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor(r -> {
            Thread t = new Thread(r, "booking-completion-scheduler");
            t.setDaemon(true);
            return t;
        });

        long initialDelay = secondsUntilMidnight();

        scheduler.scheduleAtFixedRate(this::runCompletion, initialDelay, TimeUnit.DAYS.toSeconds(1), TimeUnit.SECONDS);

        // Also run immediately on startup to catch any bookings missed while server was down
        scheduler.execute(this::runCompletion);

        log.info("BookingCompletionScheduler started. Next scheduled run in " + initialDelay + "s (midnight).");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }

    private void runCompletion() {
        try {
            int updated = bookingDAO.completeExpiredBookings();
            if (updated > 0) {
                log.info("Auto-completed " + updated + " expired booking(s).");
            }
        } catch (Exception e) {
            log.log(Level.SEVERE, "Error in booking completion scheduler.", e);
        }
    }

    private long secondsUntilMidnight() {
        ZonedDateTime now = ZonedDateTime.now(ZoneId.systemDefault());
        ZonedDateTime midnight = now.toLocalDate().plusDays(1).atStartOfDay(ZoneId.systemDefault());
        return ChronoUnit.SECONDS.between(now, midnight);
    }
}
