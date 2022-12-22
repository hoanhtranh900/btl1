package com.example.btl1.repository;

import com.example.btl1.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long>, JpaSpecificationExecutor {
    User findByUsername(String username);

    User findByEmail(String email);

    @Query("select u from User u where u.username = ?1")
    Optional<User> findByUsername1(String admin);
}
