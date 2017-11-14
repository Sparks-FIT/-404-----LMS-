# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2017-11-13 18:38
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('lms', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Aluno',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('ra', models.CharField(max_length=7, verbose_name='ra')),
                ('nome', models.CharField(max_length=120, verbose_name='nome')),
                ('email', models.CharField(max_length=80, verbose_name='email')),
                ('celular', models.CharField(max_length=11, verbose_name='celular')),
                ('sigla_curso', models.CharField(max_length=5, verbose_name='sigla_curso')),
            ],
        ),
    ]