from django.db import models

class Task(models.Model):
    title = models.CharField(max_length=255)
    completed = models.BooleanField(default=False)
    parent = models.ForeignKey(
        'self', null=True, blank=True, related_name='children', on_delete=models.CASCADE
    )

    def __str__(self):
        return self.title

    # Метод для нумерации задачи
    def get_numbering(self):
        numbering = []
        task = self
        while task:
            siblings = task.parent.children.all() if task.parent else Task.objects.filter(parent=None)
            position = list(siblings).index(task) + 1
            numbering.append(position)
            task = task.parent
        return '.'.join(map(str, numbering[::-1]))