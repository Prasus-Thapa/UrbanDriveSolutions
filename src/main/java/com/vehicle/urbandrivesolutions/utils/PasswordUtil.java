package com.vehicle.urbandrivesolutions.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    private PasswordUtil() {
    }

    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
