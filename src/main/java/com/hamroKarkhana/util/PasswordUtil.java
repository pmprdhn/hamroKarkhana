package com.hamroKarkhana.util;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class PasswordUtil {

    private static final String ENCRYPT_ALGO = "AES/GCM/NoPadding";
    private static final int TAG_LENGTH_BIT = 128; // GCM tag length
    private static final int IV_LENGTH_BYTE = 12; // Recommended 12 bytes IV
    private static final int SALT_LENGTH_BYTE = 16; // 16-byte salt length
    private static final Charset UTF_8 = StandardCharsets.UTF_8;

    // Method to generate random nonce (IV) of specified length
    public static byte[] getRandomNonce(int numBytes) {
        byte[] nonce = new byte[numBytes];
        new SecureRandom().nextBytes(nonce);
        return nonce;
    }

    // Method to generate AES key from password and salt
    public static SecretKey getAESKeyFromPassword(char[] password, byte[] salt) {
        try {
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec spec = new PBEKeySpec(password, salt, 65536, 256); // 65536 iterations and 256-bit key
            SecretKey secret = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
            return secret;
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            Logger.getLogger(PasswordUtil.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Method to encrypt the password with AES encryption and return a base64 encoded string
    public static String encrypt(String username, String password) {
        try {
            // 16-byte random salt
            byte[] salt = getRandomNonce(SALT_LENGTH_BYTE);

            // 12-byte random IV for GCM
            byte[] iv = getRandomNonce(IV_LENGTH_BYTE);

            // Generate AES key from username and salt
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);

            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.ENCRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));

            // Encrypt the password
            byte[] cipherText = cipher.doFinal(password.getBytes(UTF_8));

            // Prefix IV and Salt to cipher text for easy retrieval during decryption
            byte[] cipherTextWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                    .put(iv)
                    .put(salt)
                    .put(cipherText)
                    .array();

            // Return base64 encoded string of the encrypted password with IV and salt
            return Base64.getEncoder().encodeToString(cipherTextWithIvSalt);
        } catch (Exception ex) {
            Logger.getLogger(PasswordUtil.class.getName()).log(Level.SEVERE, "Encryption failed", ex);
            return null;
        }
    }

    // Method to decrypt the encrypted password using the stored username and salt
    public static String decrypt(String encryptedPassword, String username) {
        try {
            byte[] decode = Base64.getDecoder().decode(encryptedPassword);

            // Extract IV and salt from the encrypted password
            ByteBuffer bb = ByteBuffer.wrap(decode);
            byte[] iv = new byte[IV_LENGTH_BYTE];
            bb.get(iv);

            byte[] salt = new byte[SALT_LENGTH_BYTE];
            bb.get(salt);

            byte[] cipherText = new byte[bb.remaining()];
            bb.get(cipherText);

            // Generate AES key from username and salt
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(username.toCharArray(), salt);

            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.DECRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));

            // Decrypt the password
            byte[] plainText = cipher.doFinal(cipherText);

            // Return the decrypted password as a string
            return new String(plainText, UTF_8);
        } catch (Exception ex) {
            Logger.getLogger(PasswordUtil.class.getName()).log(Level.SEVERE, "Decryption failed", ex);
            return null;
        }
    }
}
