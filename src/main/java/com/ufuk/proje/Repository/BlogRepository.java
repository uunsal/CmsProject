package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.Blog;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BlogRepository extends JpaRepository<Blog,Integer> {
    @Query("SELECT b FROM Blog b ORDER BY b.id desc")
    List<Blog> findAllBlog(Pageable pageable);
}
