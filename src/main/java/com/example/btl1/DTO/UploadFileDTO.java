package com.example.btl1.DTO;

import lombok.Data;

import java.util.List;

@Data
public class UploadFileDTO {
    private Long objectId;
    private List<Long> listFileIds;
}
