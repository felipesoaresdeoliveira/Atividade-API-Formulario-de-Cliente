import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';

interface Cliente {
  id?: number;
  nome: string;
  tipoPessoa: string;
  cpfCnpj: string;
  telefone: string;
  email: string;
  logradouro: string;
  numero: string;
  bairro: string;
  cep: string;
  cidade: string;
}

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
  private readonly apiUrl = 'http://localhost:8080/clientes';

  cliente: Cliente = this.novoCliente();
  clientes: Cliente[] = [];
  mensagem = '';
  mensagemErro = false;
  salvando = false;
  carregando = false;

  constructor(private readonly http: HttpClient) {}

  ngOnInit(): void {
    this.carregarClientes();
  }

  salvar(): void {
    if (!this.cliente.nome.trim()) {
      this.mostrarMensagem('Informe o nome do cliente.', true);
      return;
    }

    this.salvando = true;
    this.mensagem = '';

    this.http.post<Cliente>(`${this.apiUrl}/salvar-cliente`, this.cliente).subscribe({
      next: () => {
        this.cliente = this.novoCliente();
        this.salvando = false;
        this.mostrarMensagem('Cliente cadastrado com sucesso!', false);
        this.carregarClientes();
      },
      error: () => {
        this.salvando = false;
        this.mostrarMensagem('Não foi possível cadastrar o cliente.', true);
      }
    });
  }

  carregarClientes(): void {
    this.carregando = true;

    this.http.get<Cliente[]>(`${this.apiUrl}/listar-clientes`).subscribe({
      next: (clientes) => {
        this.clientes = clientes;
        this.carregando = false;
      },
      error: () => {
        this.carregando = false;
        this.mostrarMensagem('Não foi possível carregar os clientes. Verifique se a API está ligada.', true);
      }
    });
  }

  private mostrarMensagem(texto: string, erro: boolean): void {
    this.mensagem = texto;
    this.mensagemErro = erro;
  }

  private novoCliente(): Cliente {
    return {
      nome: '',
      tipoPessoa: 'PF',
      cpfCnpj: '',
      telefone: '',
      email: '',
      logradouro: '',
      numero: '',
      bairro: '',
      cep: '',
      cidade: ''
    };
  }
}
