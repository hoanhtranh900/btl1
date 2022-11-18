package com.example.btl1.service;

public interface SecurityService {
    String findLoggedInUsername();

    void autologin(String username, String password);
}
