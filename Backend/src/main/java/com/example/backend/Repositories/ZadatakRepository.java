package com.example.backend.Repositories;

import com.example.backend.Models.Zadatak;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ZadatakRepository extends JpaRepository<Zadatak, Long> {
}
