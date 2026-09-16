package com.felipe.clientes;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/clientes")
public class ClienteController {

    private final List<Cliente> clientes = new ArrayList<>();
    private final AtomicLong sequencia = new AtomicLong(1);

    @PostMapping("/salvar-cliente")
    @ResponseStatus(HttpStatus.OK)
    public synchronized Cliente salvar(@RequestBody Cliente cliente) {
        if (cliente.getNome() == null || cliente.getNome().trim().isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Nome e obrigatorio");
        }

        cliente.setId(sequencia.getAndIncrement());
        clientes.add(cliente);
        return cliente;
    }

    @GetMapping("/listar-clientes")
    public synchronized List<Cliente> listar() {
        return new ArrayList<>(clientes);
    }
}
