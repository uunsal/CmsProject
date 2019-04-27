package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Blog;

import org.springframework.data.domain.Pageable;

import java.util.List;

public interface BlogService {
    public List<Blog> findAll(Pageable pageable);
    public void createBlog(Blog blog);

    int findAllSize();
}
