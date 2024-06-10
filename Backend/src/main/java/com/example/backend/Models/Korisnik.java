package com.example.backend.Models;


import jakarta.persistence.*;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Entity
public class Korisnik {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Polje ime je obvezno.")
    private String ime;

    @NotBlank(message = "Polje prezime je obvezno.")
    private String prezime;

    @Email(message = "Polje email je obvezno.")
    private String email;

    @NotBlank(message = "Polje lozinka je obvezno")
    private String lozinka;

    @Transient
    @NotBlank(message = "Polje potvrda lozinke je obvezno")
    private String potvrdaLozinke;


    @AssertTrue(message = "Lozinke se moraju podudarati")
    public boolean podudaranjeLozinki(){

        try{
            return this.lozinka.equals(this.potvrdaLozinke);
        }
        catch (Exception e){
            return false;
        }

    }


    public Korisnik(Long id, String ime, String prezime, String email, String lozinka, String potvrdaLozinke) {
        this.id = id;
        this.ime = ime;
        this.prezime = prezime;
        this.email = email;
        this.lozinka = lozinka;
        this.potvrdaLozinke = potvrdaLozinke;
    }

    public Korisnik() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getIme() {
        return ime;
    }

    public void setIme(String ime) {
        this.ime = ime;
    }

    public String getPrezime() {
        return prezime;
    }

    public void setPrezime(String prezime) {
        this.prezime = prezime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLozinka() {
        return lozinka;
    }

    public void setLozinka(String lozinka) {
        this.lozinka = lozinka;
    }

    public String getPotvrdaLozinke() {
        return potvrdaLozinke;
    }

    public void setPotvrdaLozinke(String potvrdaLozinke) {
        this.potvrdaLozinke = potvrdaLozinke;
    }
}
