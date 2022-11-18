package com.example.btl1.validator;

import com.example.btl1.model.User;
import com.example.btl1.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator {
    @Autowired
    private UserService userService;

    //đánh dấu chỉ dành cho class User
    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "error.username", "Tên đăng nhập không được để trống");
        if (user.getUsername().length() < 6 || user.getUsername().length() > 32) {
            errors.rejectValue("username", "error.username", "Tên đăng nhập phải từ 6 đến 32 ký tự");
        }
        if (userService.findByUsername(user.getUsername()) != null) {
            errors.rejectValue("username", "error.username", "Tên đăng nhập đã tồn tại");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "error.password", "Mật khẩu không được để trống");
        if (user.getPassword().length() < 8 || user.getPassword().length() > 32) {
            errors.rejectValue("password", "error.password", "Mật khẩu phải từ 8 đến 32 ký tự");
        }

        if (!user.getPasswordConfirm().equals(user.getPassword())) {
            errors.rejectValue("passwordConfirm", "error.passwordConfirm", "Mật khẩu xác nhận không khớp");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "error.email", "Email không được để trống");
        if (userService.findByEmail(user.getEmail()) != null) {
            errors.rejectValue("email", "error.email", "Email đã tồn tại");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "fullName", "error.fullName", "Họ tên không được để trống");

    }
}
