package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.initalize.initalize_model;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InıtalizeModelRepository  extends JpaRepository<initalize_model,Integer> {
    initalize_model findByUrl(String url);
    initalize_model findByUserUsername(String username);
}
