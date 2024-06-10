package com.example.backend.Services;

import com.example.backend.Models.Zadatak;
import com.example.backend.Repositories.ZadatakRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ZadatakService {

    @Autowired
    ZadatakRepository zadatakRepository;

    public List<Zadatak> getAllZadaci(){

        return zadatakRepository.findAll();

    }

    public Zadatak createZadatak(Zadatak zadatak){

        return zadatakRepository.save(zadatak);

    }

    public void deleteZadatak(Long id){

         zadatakRepository.deleteById(id);

    }

    public Zadatak updateZadatak(Long id, Zadatak noviZadatak) {
        Zadatak zadatak = zadatakRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Zadatak ne postoji"));

        zadatak.setNaziv(noviZadatak.getNaziv());
        zadatak.setStatus(noviZadatak.isStatus());

        return zadatakRepository.save(zadatak);
    }
}
