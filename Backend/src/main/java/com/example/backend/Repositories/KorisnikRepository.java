package com.example.backend.Repositories;


import com.example.backend.Models.Korisnik;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface KorisnikRepository extends JpaRepository<Korisnik, Long> {

        Korisnik findByEmail(String email);

        boolean existsByEmail(String email);

}
