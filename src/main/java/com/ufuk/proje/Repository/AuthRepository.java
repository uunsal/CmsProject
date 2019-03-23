package com.ufuk.proje.Repository;

import com.ufuk.proje.Model.authorities;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthRepository extends JpaRepository<authorities,Integer> {
}
