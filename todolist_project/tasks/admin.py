from django.contrib import admin
from .models import Task

@admin.register(Task)
class TaskAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'parent', 'completed')
    list_filter = ('completed', 'parent')
    search_fields = ('title',)