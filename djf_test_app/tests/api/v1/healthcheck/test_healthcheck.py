from rest_framework import status
from rest_framework.reverse import reverse
from rest_framework.test import APIClient

import pytest


@pytest.mark.django_db
class TestHealthcheckView:

    def setup_method(self):
        self.client = APIClient()
        self.url = reverse("api:v1:healthcheck")

    def test_healthcheck(self):
        response = self.client.get(self.url, format="json")
        assert response.status_code == status.HTTP_200_OK
