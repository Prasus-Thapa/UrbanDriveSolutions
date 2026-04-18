package com.vehicle.urbandrivesolutions.entity;

import java.math.BigDecimal;

public class DashboardAnalytics {
    private BigDecimal totalRevenue;
    private BigDecimal cardRevenue;
    private BigDecimal esewaRevenue;
    private BigDecimal khaltiRevenue;
    private BigDecimal connectIpsRevenue;
    private int totalPaidPayments;
    private int totalPendingPayments;
    private int totalBookings;
    private int totalConfirmedBookings;
    private int totalVehicles;
    private int availableVehicles;

    public DashboardAnalytics() {
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public BigDecimal getCardRevenue() {
        return cardRevenue;
    }

    public void setCardRevenue(BigDecimal cardRevenue) {
        this.cardRevenue = cardRevenue;
    }

    public BigDecimal getEsewaRevenue() {
        return esewaRevenue;
    }

    public void setEsewaRevenue(BigDecimal esewaRevenue) {
        this.esewaRevenue = esewaRevenue;
    }

    public BigDecimal getKhaltiRevenue() {
        return khaltiRevenue;
    }

    public void setKhaltiRevenue(BigDecimal khaltiRevenue) {
        this.khaltiRevenue = khaltiRevenue;
    }

    public BigDecimal getConnectIpsRevenue() {
        return connectIpsRevenue;
    }

    public void setConnectIpsRevenue(BigDecimal connectIpsRevenue) {
        this.connectIpsRevenue = connectIpsRevenue;
    }

    public int getTotalPaidPayments() {
        return totalPaidPayments;
    }

    public void setTotalPaidPayments(int totalPaidPayments) {
        this.totalPaidPayments = totalPaidPayments;
    }

    public int getTotalPendingPayments() {
        return totalPendingPayments;
    }

    public void setTotalPendingPayments(int totalPendingPayments) {
        this.totalPendingPayments = totalPendingPayments;
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }

    public int getTotalConfirmedBookings() {
        return totalConfirmedBookings;
    }

    public void setTotalConfirmedBookings(int totalConfirmedBookings) {
        this.totalConfirmedBookings = totalConfirmedBookings;
    }

    public int getTotalVehicles() {
        return totalVehicles;
    }

    public void setTotalVehicles(int totalVehicles) {
        this.totalVehicles = totalVehicles;
    }

    public int getAvailableVehicles() {
        return availableVehicles;
    }

    public void setAvailableVehicles(int availableVehicles) {
        this.availableVehicles = availableVehicles;
    }
}
