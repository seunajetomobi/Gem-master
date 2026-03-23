from django.test import TestCase, Client


class PingAPITest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_ping_endpoint(self):
        resp = self.client.get('/api/ping/')
        self.assertEqual(resp.status_code, 200)
        self.assertJSONEqual(resp.content, {'ok': True, 'message': 'pong'})
