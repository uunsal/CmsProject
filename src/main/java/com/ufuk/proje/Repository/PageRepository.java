package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.persistence.OrderBy;
import java.util.List;

@Repository
public interface PageRepository extends JpaRepository<Page,Integer> {
    public Page findByTitle(String title);
    public Page findByUrl(String url);
    public List<Page> findByPageType(String pageType);
    @Query("SELECT P FROM Page P where is_draft=false order by sort_numbers")
    public List<Page> findByIsDraft(Boolean isDraft);
}
