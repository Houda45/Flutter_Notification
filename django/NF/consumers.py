import json
from channels.generic.websocket import AsyncWebsocketConsumer

class NotificationConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

    async def disconnect(self, close_code):
        pass

    async def receive(self, text_data):
        # Traitez les données (par exemple, informations sur la réservation) et envoyez la notification
        await self.send(text_data=json.dumps({
            'type': 'notification',
            'message': 'Nouvelle réservation',
        }))