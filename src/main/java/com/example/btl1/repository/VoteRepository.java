package com.example.btl1.repository;

import com.example.btl1.model.Vote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VoteRepository extends JpaRepository<Vote, Long> {
    @Query("select v from Vote v where v.book.id = ?1 order by v.voteDate desc")
    List<Vote> findByBook_Id(Long id);


}
