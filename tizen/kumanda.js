// Monitöre Mac'ten sanal kumanda tuşu gönderir (Samsung'un yerel ağ kumanda arayüzü; SmartThings de bunu kullanır).
// İlk bağlantıda monitörde "izin ver" penceresi çıkar; izin verilince anahtar .kumanda-token dosyasına kaydedilir.
// Kullanım: NODE_TLS_REJECT_UNAUTHORIZED=0 node kumanda.js 192.168.1.6 KEY_1 KEY_2 KEY_3 KEY_4 KEY_5
'use strict';
const fs = require('fs');
const path = require('path');

const [ip, ...keys] = process.argv.slice(2);
if (!ip || !keys.length) {
  console.log('Kullanım: node kumanda.js <monitör-ip> KEY_1 KEY_2 …  (KEY_HOME, KEY_ENTER, KEY_RETURN, KEY_UP/DOWN/LEFT/RIGHT)');
  process.exit(1);
}
const tokenFile = path.join(__dirname, '.kumanda-token');
const token = fs.existsSync(tokenFile) ? fs.readFileSync(tokenFile, 'utf8').trim() : '';
const name = Buffer.from('Mac Kumanda').toString('base64');
const url = `wss://${ip}:8002/api/v2/channels/samsung.remote.control?name=${name}` + (token ? `&token=${token}` : '');

const ws = new WebSocket(url);
const timer = setTimeout(() => { console.log('✗ Cevap gelmedi. Monitörde izin penceresi çıktıysa "İzin ver"e bas ve tekrar dene.'); process.exit(1); }, 90000);
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

ws.onmessage = async (ev) => {
  const msg = JSON.parse(ev.data);
  if (process.env.DEBUG) console.log('  (monitör)', msg.event, JSON.stringify(msg.data || '').slice(0, 120));
  if (msg.event === 'ms.channel.unauthorized') {
    console.log('✗ Monitör izin vermedi. Pencere çıkınca "İzin ver"i seç.');
    process.exit(1);
  }
  if (msg.event !== 'ms.channel.connect') return;
  if (msg.data && msg.data.token) fs.writeFileSync(tokenFile, String(msg.data.token));
  console.log('✓ Bağlandı');
  for (const key of keys) {
    ws.send(JSON.stringify({ method: 'ms.remote.control', params: { Cmd: 'Click', DataOfCmd: key, Option: 'false', TypeOfRemote: 'SendRemoteKey' } }));
    console.log('  →', key);
    await sleep(500);
  }
  clearTimeout(timer);
  await sleep(300);
  ws.close();
  process.exit(0);
};
ws.onerror = (e) => { console.log('✗ Bağlantı hatası:', e.message || e.type); process.exit(1); };
