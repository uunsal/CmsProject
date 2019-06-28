package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.authorities;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuthRepository extends JpaRepository<authorities,Integer> {
    List<authorities> findByAuthority(String auth);
}
