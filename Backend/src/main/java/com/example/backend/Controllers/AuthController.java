package com.example.backend.Controllers;

import com.example.backend.Models.Korisnik;
import com.example.backend.Services.KorisnikService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "http://localhost:52138")
public class AuthController {

    @Autowired
    KorisnikService korisnikService;

    @PostMapping("/registracija")
    public ResponseEntity<String> registracijaKorisnika(@RequestBody Korisnik korisnik){

        try{
        korisnikService.registracija(korisnik);
        return new ResponseEntity<>("Registracija uspješna", HttpStatus.CREATED);
        }
        catch (RuntimeException e){

            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);

        }

    }

    @PostMapping("/prijava")
    public ResponseEntity<String> prijavaKorisnika(@RequestBody Korisnik korisnik) {
        try {
            korisnikService.prijava(korisnik.getEmail(), korisnik.getLozinka());
            return new ResponseEntity<>("Prijava uspješna", HttpStatus.OK);
        }
        catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }
    }
}
