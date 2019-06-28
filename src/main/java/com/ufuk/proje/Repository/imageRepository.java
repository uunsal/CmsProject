package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface imageRepository extends JpaRepository<image,Integer> {
    List<image> findByUsername(String username);
}
