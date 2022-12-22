package com.example.btl1.web;

import com.example.btl1.model.Role;
import com.example.btl1.model.User;
import com.example.btl1.repository.RoleRepository;
import com.example.btl1.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashSet;

@Service
public class BeanInitDatabase {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostConstruct
    public void initDatabase() {
        if (!userRepository.findByUsername1("admin").isPresent()) {
            User user = new User();
            user.setUsername("admin");
            user.setPassword(bCryptPasswordEncoder.encode("admin"));
            Role adminRole = roleRepository.findByName("ROLE_ADMIN");
            user.setRoles(new HashSet<Role>() {{
                add(adminRole);
            }});
            user.setFullName("Admin");
            userRepository.save(user);
        }
    }
}

