package com.example.btl1.repository;

import com.example.btl1.model.FileAttachDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FileAttachDocumentRepository extends JpaRepository<FileAttachDocument, Long>, JpaSpecificationExecutor<FileAttachDocument> {
    Optional<FileAttachDocument> findById(Long id);

    @Query("select f from FileAttachDocument f where f.objectId = ?1")
    List<FileAttachDocument> findByObjectId(Long objectId);

}