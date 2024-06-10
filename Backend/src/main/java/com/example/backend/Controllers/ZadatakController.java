package com.example.backend.Controllers;

import com.example.backend.Models.Zadatak;
import com.example.backend.Services.ZadatakService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/zadaci")
public class ZadatakController {

    @Autowired
    ZadatakService zadatakService;

    @GetMapping
    public ResponseEntity<List<Zadatak>> getAllZadaci(){

        List<Zadatak> zadaci = zadatakService.getAllZadaci();
        return ResponseEntity.ok(zadaci);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Zadatak> deleteZadatak(@PathVariable Long id){

        zadatakService.deleteZadatak(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping
    public ResponseEntity<Zadatak> createZadatak(@RequestBody Zadatak zadatak){

        Zadatak noviZadatak = zadatakService.createZadatak(zadatak);
        return ResponseEntity.ok(noviZadatak);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Zadatak> updateZadatak(@PathVariable Long id, @RequestBody Zadatak noviZadatak){

        Zadatak azurirani = zadatakService.updateZadatak(id, noviZadatak);
        return ResponseEntity.ok(azurirani);
    }
}