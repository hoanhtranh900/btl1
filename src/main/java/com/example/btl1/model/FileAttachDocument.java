package com.example.btl1.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
public class FileAttachDocument {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "OBJECT_ID")
    private Long objectId;

    @Column(name = "FILE_NAME", length = 150)
    private String fileName;

    @Column(name = "FILE_PATH", length = 1000)
    private String filePath;

    @Column(name = "FILE_SIZE", length = 1000)
    private Long fileSize;
}
