package com.example.btl1.service;

import com.example.btl1.model.User;

public interface UserService {
    void save(User user);

    User findByUsername(String username);

    User findByEmail(String email);
}
