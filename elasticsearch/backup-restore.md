## Backup
1. Mount same filesystem on every node
2. Add a repository path on every node by put this into every elasticsearch.yml file: 
    ```
    # Specifies the root folder for backups
    path.repo: ["/backup/es_save"]
    ```
3. Create a repository via snapshot api:
    ```
    PUT /_snapshot/<name-of-repository>
    {
     "type": "fs",
     "settings": {
     "location": "/backup/es_save/backup-6.1.3/",
     "compress": true
     }
    }
    ```
4. Start snapshot creation
    ```
    PUT /_snapshot/indices-6.1.3/snapshot_1?wait_for_completion=false
    {
    }
    ```

5. Get snapshot status
    ```
    GET /_snapshot/indices-6.1.3/snapshot_1
    ```
## Restore
POST /_snapshot/<name-of-repository>/snapshot_1/_restore
    

