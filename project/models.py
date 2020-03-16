from django.db import models
from passlib.hash import pbkdf2_sha256

class User(models.Model):
    username = models.CharField(max_length = 32)
    password = models.CharField(max_length = 256)
    
    def verify_password(self, raw_password):
        return pbkdf2_sha256.verify(raw_password, self.password)
