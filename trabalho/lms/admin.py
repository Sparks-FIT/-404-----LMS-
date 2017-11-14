from django.contrib import admin
from lms.models import Curso, Aluno
# Register your models here.

class CursoAdmin(admin.ModelAdmin):
    list_display = ["nome", "sigla"]
    search_fields = ["nome", "sigla"]


class AlunoAdmin(admin.ModelAdmin):
    list_display = ["nome", "ra", "sigla_curso"]
    search_fields = ["nome", "ra", "sigla_curso"]



admin.site.register(Curso, CursoAdmin)
admin.site.register(Aluno, AlunoAdmin)
