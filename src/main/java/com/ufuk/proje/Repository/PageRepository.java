package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PageRepository extends JpaRepository<Page,Integer> {
    public Page findByTitle(String title);
    public Page findByUrl(String url);
    public List<Page> findByPageType(String pageType);
    public List<Page> findByIsDraft(Boolean isDraft);
}
