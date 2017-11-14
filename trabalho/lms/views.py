from django.shortcuts import render

# Create your views here.


def home (request):
    return render(request, "index.html")
def sobre(request):
    return render(request, "sobre.html")
def insc(request):
    return render(request, "inscricao.html")
def prof(request):
    return render(request, "professor.html")
def aluno(request):
    return render(request, "aluno.html")

