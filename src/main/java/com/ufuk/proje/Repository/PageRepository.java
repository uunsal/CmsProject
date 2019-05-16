package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PageRepository extends JpaRepository<Page, Integer> {
    public Page findByTitle(String title);

    public Page findByUrl(String url);

    public List<Page> findByPageType(String pageType);
    public List<Page> findByIsDraftAndUserUsernameOrderBySortNumber(Boolean isDraft, String username);

    public List<Page> findAllByUserUsername(String username);

    public Page findByPageTypeAndUserUsername(String pageType,String username);

    public Page findByUrlAndUserUsername(String url, String principles);
}
