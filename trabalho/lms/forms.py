from django import forms
from core.models import Disciplina, Contato, Avisos, MensagemAluno

class ContatoForm(forms.ModelForm):

    class Meta:
        model = Contato
        fields = ["assunto", "nome", "email", "mensagem"]

    def envia_email(self, contato):
    	print("ENVIADO")

class DisciplinaForm(forms.ModelForm):

    class Meta:
        model = Disciplina
        fields = "__all__"
        
    def save(self):
        nova_disciplina = super(DisciplinaForm, self).save()
        self.envia_email(contato='ok')
        return nova_disciplina
    
    def envia_email(self, contato):
        message = "DISCIPLINA CADASTRADA"
        print("OK - ", message)

class AvisosForm(forms.ModelForm):

    class Meta :
        model = Avisos
        fields = ["titulo", "turma", "texto"]

class MensagemAlunoForm(forms.ModelForm):

    class Meta :
        model = MensagemAluno
        fields = ["assunto", "professor", "mensagem"]
