package com.example.backend.Controllers;

import com.example.backend.Models.Korisnik;
import com.example.backend.Services.KorisnikService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController("/api/korisnik")
public class KorisnikController {

    @Autowired
    KorisnikService korisnikService;


    @GetMapping("/listaKorisnika")
    public ResponseEntity<List<Korisnik>> getAllKorisnici(){

        List<Korisnik> korisnici = korisnikService.getAllKorisnici();
        return ResponseEntity.ok(korisnici);
    }

    @PostMapping
    public ResponseEntity<Korisnik> createKorisnik(@RequestBody Korisnik korisnik) {

        Korisnik noviKorisnik = korisnikService.createKorisnik(korisnik);
        return ResponseEntity.ok(noviKorisnik);
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteKorisnik(@PathVariable Long id) {

        korisnikService.deleteKorisnik(id);
        return ResponseEntity.noContent().build();
    }


    @PutMapping("/{id}")
    public ResponseEntity<Korisnik> updateKorisnik(@PathVariable Long id, @RequestBody Korisnik noviKorisnik) {

        Korisnik azuriraniKorisnik = korisnikService.updateKorisnik(id, noviKorisnik);
        return ResponseEntity.ok(azuriraniKorisnik);
    }


}