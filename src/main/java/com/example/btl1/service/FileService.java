package com.example.btl1.service;

import com.example.btl1.model.FileAttachDocument;
import com.example.btl1.repository.FileAttachDocumentRepository;
import com.example.btl1.utils.H;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.nio.file.*;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

@Service
@Transactional(rollbackFor = Exception.class)
public class FileService {
    @Autowired
    private FileAttachDocumentRepository attachDocumentRepository;
    private String uploadFolder = "D:\\uploadFileFolder";

    public FileAttachDocument uploadFile(MultipartFile multipartFile, Long id) throws IOException {
        FileAttachDocument vbAttachment = new FileAttachDocument();
        String randomName = UUID.randomUUID().toString();
        String reNameFile = randomName + "." + H.getFileExtension(multipartFile.getOriginalFilename());

        File finalOriginalFile = saveFile(reNameFile, multipartFile.getInputStream());

        vbAttachment.setFileName(reNameFile);
        vbAttachment.setFilePath(finalOriginalFile.getAbsolutePath());
        vbAttachment.setObjectId(id);
        vbAttachment.setFileSize(multipartFile.getSize());

        return attachDocumentRepository.save(vbAttachment);
    }

    public File saveFile(String id, InputStream inputStream) {
        try {
            File targetFile = getLocalFile(id);
            OutputStream outputStream = new FileOutputStream(targetFile);
            writeFile(inputStream, outputStream);
            return targetFile;
        } catch (Exception e) {
            System.out.println("debug 1192");
        }
        return null;
    }


    public File getLocalFile(String id) {
        String dir = this.uploadFolder;
        File directory = new File(dir);
        if (!directory.exists()) directory.mkdirs();
        String targetFilePath = dir + "/" + id;
        return new File(targetFilePath);
    }

    public void writeFile(InputStream inputStream, OutputStream os) throws IOException {
        try {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.flush();
        } finally {
            close(inputStream);
            close(os);
        }
    }

    private void close(Closeable closeable) {
        try {
            if (closeable != null) closeable.close();
        } catch (Exception ex) {
        }
    }

    public List<FileAttachDocument> findByObjectId(Long id) {
        return attachDocumentRepository.findByObjectId(id);
    }

    public String getFile(FileAttachDocument fileAttachDocument) {
        try {
            InputStream inputStream = new FileInputStream(fileAttachDocument.getFilePath());
            String base64 = Base64.getEncoder().encodeToString(IOUtils.toByteArray(inputStream));
            return base64;
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    public List<FileAttachDocument> getAllByObjectId(Long id) {
        return attachDocumentRepository.findByObjectId(id);
    }

    public void delete(Long id) throws IOException {
        //delete file by file-path
        FileAttachDocument fileAttachDocument = attachDocumentRepository.findById(id).get();
//        File file = new File(fileAttachDocument.getFilePath());
//        try (InputStream inputStream = new FileInputStream
//                (fileAttachDocument.getFilePath())) {
//            Files.deleteIfExists(file.toPath());
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }

        //close
//        Files.deleteIfExists(Paths.get(fileAttachDocument.getFilePath()));

        attachDocumentRepository.delete(id);
    }

//    public ResponseEntity<InputStreamResource> downloadFile(HttpServletResponse response, Long attachmentId, DownloadOption downloadOption) throws Exception {
//        Optional<FileAttachment> attachmentOpt = attachmentRepository.findByIdAndIsDelete(attachmentId, ConstantString.IS_DELETE.active);
//        if (!attachmentOpt.isPresent()) {
//            throw new BadRequestException(
//                    messageSource.getMessage("error.ENTITY_NOT_FOUND", new Object[]{"File"}, UtilsCommon.getLocale())
//            );
//        }
//        FileAttachment attachment = attachmentOpt.get();
//        InputStream inputStream = storageService.getInputStream(attachmentDocumentService.get(attachment.getFileServiceId()).get());
//        String contentType = H.isTrue(downloadOption.getType()) ? downloadOption.getType() : attachment.getContentType();
//        return ResponseEntity.ok()
//                .header(HttpHeaders.CONTENT_DISPOSITION, "inline;filename=" + UtilsString.encodeStringToUrlParam(attachment.getFileName()))
//                .contentType(MediaType.valueOf(contentType))
//                .body(new InputStreamResource(inputStream));
//
//    }
    public ResponseEntity<InputStreamResource> downloadFile(HttpServletResponse response, Long productId) {
        List<FileAttachDocument> fileAttachDocuments = attachDocumentRepository.findByObjectId(productId);
        if(fileAttachDocuments.size() > 0 ) {
            FileAttachDocument fileAttachDocument = fileAttachDocuments.get(0);
            try {
                InputStream inputStream = new FileInputStream(fileAttachDocument.getFilePath());
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline;filename=" + fileAttachDocument.getFileName())
                        .contentType(MediaType.valueOf("application/octet-stream"))
                        .body(new InputStreamResource(inputStream));
            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            }
        }
        else {
            //return empty image
            //https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg
            //convert image in link to inputstream
            try {
                InputStream inputStream = new URL("https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg").openStream();
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline;filename=" + "empty.jpg")
                        .contentType(MediaType.valueOf("application/octet-stream"))
                        .body(new InputStreamResource(inputStream));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }


}
