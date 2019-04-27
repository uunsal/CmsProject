package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Blog;
import com.ufuk.proje.Repository.BlogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Service
public class BlogServiceImpl implements BlogService {

    private final BlogRepository blogRepository;

    @Autowired
    public BlogServiceImpl(BlogRepository blogRepository) {
        this.blogRepository = blogRepository;
    }


    @Override
    public List<Blog> findAll(Pageable pageable) {
        return blogRepository.findAllBlog(pageable);
    }

    @Override
    public void createBlog(Blog blog) {
        blogRepository.save(blog);
    }

    @Override
    public int findAllSize() {
        return blogRepository.findAll().size();
    }

}
