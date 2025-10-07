# ライブラリインポート Python一般
import io
import os.path
import matplotlib.pyplot as plt
import sys
from PIL import Image
#  ライブラリインポート　Google API関係
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from googleapiclient.http import MediaIoBaseDownload

import argparse
# 変数定義
SCOPES = ['https://www.googleapis.com/auth/drive.file']
MIME_TYPE = 'application/vnd.google-apps.document'
APPLICATION_NAME = 'ipa-google-drive-api-client'
# TOKEN = 'token.json'
# CRED_JSON='cre.json'
TMP_FILE="ocr_check_tmp.txt"

parser = argparse.ArgumentParser(description='google drive ocr.')
parser.add_argument('-i', help='ocr file.')
parser.add_argument('-a', help='googe api access token.')
parser.add_argument('-c', help='googe api credential file.')
args = parser.parse_args()

TOKEN = args.a
CRED_JSON = args.c
INPUT_FILE= args.i
# Google Drive API用サービス取得
def get_service():

    # credentialの取得
    creds = None
    if os.path.exists(TOKEN):
        creds = Credentials.from_authorized_user_file(TOKEN, SCOPES)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                CRED_JSON, SCOPES)
            creds = flow.run_local_server(port=0)
        with open(TOKEN, 'w') as token:
            token.write(creds.to_json())
        
    # serviceの取得
    service = build('drive', 'v3', credentials=creds) 
    
    return service

# イメージからOCR結果を取得
# def read_ocr(service, input_file, output_file, lang='en'):
def read_ocr(service, input_file, lang='en'):

    # ファイルのアップロード

    # ローカルファイルの定義
    media_body = MediaFileUpload(input_file, mimetype=MIME_TYPE, resumable=True)

    # Google Drive上のファイル名
    newfile = 'ocr_check_tmp.pdf'

    body = {
        'name': newfile,
        'mimeType': MIME_TYPE
    }

    # 　creat関数でファイルアップロード実行
    # 同時にOCR読み取りも行う
    output = service.files().create(
        body=body,
        media_body=media_body,
        ocrLanguage=lang,
    ).execute()

    # テキストファイルのダウンロード

    # リクエストオブジェクト生成
    request = service.files().export_media(
        fileId=output['id'],
        mimeType = "text/plain"
    )

    #  出力用テキストファイル名
    output_path = 'output.txt'

    fh = io.FileIO(TMP_FILE, "wb")
    # fh = io.FileIO(output_file, "wb")
    downloader = MediaIoBaseDownload(fh, request)
    done = False
    while done is False:
        status, done = downloader.next_chunk()

    # Google Drive上のファイル削除
    service.files().delete(fileId=output['id']).execute()
 
    # テキストの取得
    with open(TMP_FILE) as f:
        content_text = f.read()

    os.remove(TMP_FILE)

    return content_text

# サービスインスタンスの生成
service = get_service()

# args = sys.argv
# input_file = args[1]

#output_file = args[2]
#o2 = read_ocr(service, input_file, output_file, 'ja')
#output_json = read_ocr(service, input_file, 'ja')
output_json = read_ocr(service, INPUT_FILE, 'ja')

# 結果確認

# テキストの表示
print(output_json)
# print(args[1])


