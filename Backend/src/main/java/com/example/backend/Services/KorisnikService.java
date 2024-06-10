package com.example.backend.Services;

import com.example.backend.Models.Korisnik;
import com.example.backend.Repositories.KorisnikRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KorisnikService {

    @Autowired
    KorisnikRepository korisnikRepository;


    public Korisnik getKorisnikById(Long id){

        return korisnikRepository.findById(id).orElse(null);

    }

    public List<Korisnik> getAllKorisnici(){

        return korisnikRepository.findAll();

    }

    public Korisnik createKorisnik(Korisnik korisnik){

        return korisnikRepository.save(korisnik);

    }

    public void deleteKorisnik(Long id){

        korisnikRepository.deleteById(id);

    }

    public Korisnik updateKorisnik(Long id,Korisnik noviKorisnik){

        Korisnik korisnik = korisnikRepository.findById(id)
                .orElseThrow(() ->new EntityNotFoundException("Korisnik ne postoji"));

        korisnik.setIme(noviKorisnik.getIme());
        korisnik.setPrezime(noviKorisnik.getPrezime());
        korisnik.setEmail(noviKorisnik.getEmail());
        korisnik.setLozinka(noviKorisnik.getLozinka());
        korisnik.setPotvrdaLozinke(noviKorisnik.getPotvrdaLozinke());

        return korisnikRepository.save(korisnik);

    }


    public Korisnik registracija(Korisnik korisnik){

        if(korisnikRepository.existsByEmail(korisnik.getEmail())){

            throw new RuntimeException("Korisnik sa istom email adresom već postoji");
        }

        if(!korisnik.podudaranjeLozinki()){

            throw new RuntimeException("Lozinke se ne podudaraju");

        }else{

            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            korisnik.setLozinka(encoder.encode(korisnik.getLozinka()));
        }

        return korisnikRepository.save(korisnik);

    }

    public void prijava(String email, String lozinka){

        Korisnik korisnik = korisnikRepository.findByEmail(email);

        if (korisnik == null) {
            throw new RuntimeException("Neuspješna prijava. Provjerite email adresu i lozinku.");
        }

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        if (!encoder.matches(lozinka, korisnik.getLozinka())) {
            throw new RuntimeException("Neuspješna prijava. Provjerite email adresu i lozinku.");
        }

    }


}