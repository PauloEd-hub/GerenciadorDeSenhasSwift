//
//  main.swift
//  ArmazenadorDeSenhasp
//
//  Created by Paulo on 11/05/23.
//

//Armazenador de Senhas
//Criar um aplicativo de linha de comando que permite ao usuário armazenar suas senhas com segurança.
//
//
//Requisitos:
//O aplicativo deve ser executado na linha de comando.
//O usuário deve ser capaz de adicionar senhas ao gerenciador, especificando um nome de usuário, senha e URL.
//O aplicativo deve armazenar os usuários, senhas e URL em um arquivo de texto. O aplicativo deve permitir que o usuário visualize todas as senhas armazenadas. O aplicativo deve permitir que o usuário remova senhas armazenadas.
//
//
//Sugestões de funcionalidades adicionais:
//O usuário deve ser capaz de editar senhas armazenadas.
//O usuário deve ser capaz ser capaz de pesquisar por uma senha especifica.
//O aplicativo deve permitir que o usuário gere senhas aleatórias para serem armazenadas.



import Foundation


print("Bem-Vindo ao Gerenciador de senhas")

struct User : Codable{
    var nomes: [String] = []
    var senhas: [String] = []
    var urls: [String] = []
}

class ViewModel {
    
    static let fileManager = FileManager.default
    
    static var documentsDirectory: URL {
        return ViewModel.fileManager.urls(for: .documentDirectory, in: .allDomainsMask).first!
    }
    
    static  var jsonUrl: URL {
        return ViewModel.documentsDirectory.appendingPathComponent("senhas.json")
    }
    
    var user: User
    
    init() {
        self.user = User()
    }
    
    func decodar() {
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: ViewModel.jsonUrl)
            let objectDecode = try decoder.decode(User.self, from: data)
            self.user.nomes = objectDecode.nomes
            self.user.senhas = objectDecode.senhas
            self.user.urls = objectDecode.urls
        }
        catch {
            print("Erro no JSON")
        }
    }
    
    func cadastro() {
        print("Digite o nome de usuário")
        if let nome = readLine() {
            user.nomes.append(nome)
            
            print("Digite a senha do usuário")
            if let senha = readLine() {
                user.nomes.append(senha)
            }
            
            print("Digite a url da usuário")
            if let url = readLine() {
                user.nomes.append(url)
            } else {
                print("Erro ao cadastrar senha")
            }
        }
    }
    func conferirSenha() {
        if user.senhas.isEmpty {
            print("Nenhuma senha cadastrada. \n")
        } else {
            print("Sehas cadastradas.\n")
            for i in 0..<user.nomes.count {
                print("cadastro \(i+1):")
                print("usuário: ",user.nomes[i])
                print("senha: ",user.senhas[i])
                print("url: ", user.urls[i],"\n")
            }
        }
    }
    
    func editarSenha() {
        if user.senhas.isEmpty {
            print("Nenhuma senha cadastrada.\n")
        } else{
            print("Digite o usuário que voce deseja editar a senha")
            if let busca = readLine() {
                for i in 0..<user.nomes.count{
                    if busca == user.nomes[i] {
                        print("Digite nova senha")
                        if let novaSenha = readLine() {
                            user.senhas[i] = novaSenha
                            print("Senha editada com sucesso!\n")
                        }
                    }
                }
            }else {
                print("Usuário inválido.\n")
            }
        }
    }
    
    func menu(){
        var userInput: String?
        print("Escolha uma opcão")
        print("1. Cadastrar nova senha")
        print("2. Editar senha existente")
        print("3. Verificar senhas cadastradas")
        print("4. Sair")
        
        userInput = readLine()
        if let input = userInput, let choice = Int(input) {
            switch choice {
            case 1:
                cadastro()
                break
            case 2:
                editarSenha()
                break
            case 3:
                conferirSenha()
                break
            case 4:
                print("Programa encerrado.")
                exit(0)
            default:
                print("Opção inválida.")
                
            }
        }
    }
    func encodeAndSave(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let data = try encoder.encode(user)
            try data.write(to: ViewModel.jsonUrl)
        } catch {
            print("Não foi possível savar os dados")
        }
        
    }
    
  }
    let viewModel = ViewModel()
    viewModel.decodar()

    while true{
        viewModel.menu()
        viewModel.encodeAndSave()
}
   


















