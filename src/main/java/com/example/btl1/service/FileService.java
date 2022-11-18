package com.example.btl1.service;

import com.example.btl1.model.FileAttachDocument;
import com.example.btl1.repository.FileAttachDocumentRepository;
import com.example.btl1.utils.H;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
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
}
