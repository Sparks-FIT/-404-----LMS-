from django.db import models

# Create your models here.

class Curso(models.Model):
    nome = models.CharField("Nome", max_length=50)
    sigla = models.SlugField("Sigla", max_length=5)
    

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = "Curso"
        verbose_name_plural = "Cursos"
        ordering=["nome"]

class Aluno(models.Model):
    ra = models.CharField("RA", max_length=7)
    nome = models.CharField("Nome", max_length=120)
    email = models.CharField("E-mail", max_length=80)
    celular = models.CharField("Celular", max_length=11)
    sigla_curso = models.CharField("Curso", max_length=5)

    def __str__(self):
        return self.nome

    class Meta:
        verbose_name = "Aluno"
        verbose_name_plural = "Alunos"
        ordering=["nome"]
