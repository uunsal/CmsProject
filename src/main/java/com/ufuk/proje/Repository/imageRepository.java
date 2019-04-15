package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface imageRepository extends JpaRepository<image,Integer> {
}
