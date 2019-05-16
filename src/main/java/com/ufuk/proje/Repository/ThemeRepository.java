package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.Theme;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ThemeRepository extends JpaRepository<Theme,Integer> {
    Theme findByUrl(String url);
}
