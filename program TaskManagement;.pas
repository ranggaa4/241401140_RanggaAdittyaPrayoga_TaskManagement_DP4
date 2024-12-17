program TaskManagement;
uses crt;

type
  Task = record
    id: integer;
    name: string;
    status: string;
  end;

const
  MAX_TASKS = 100;

var
  tasks: array[1..MAX_TASKS] of Task;
  taskCount: integer;

//Untuk menambahkan tugas
procedure AddTask(var tasks: array of Task; var taskCount: integer);
var
  taskName: string;
begin
  if taskCount < MAX_TASKS then
  begin
    write('Masukkan nama tugas: ');
    readln(taskName);
    
    if taskName = '' then
    begin
      writeln('Nama tugas tidak boleh kosong!');
      exit;
    end;

    inc(taskCount);
    tasks[taskCount].id := taskCount;
    tasks[taskCount].name := taskName;
    tasks[taskCount].status := 'Belum selesai';

    writeln('Tugas berhasil ditambahkan!');
  end
  else
    writeln('Kapasitas tugas sudah penuh. Tidak dapat menambahkan tugas lagi.');
end;

//Untuk menampilkan daftar tugas
procedure DisplayTasks(const tasks: array of Task; taskCount: integer);
var
  i: integer;
begin
  if taskCount = 0 then
    writeln('Belum ada tugas. Gunakan opsi Tambah Tugas untuk memulai.')
  else
  begin
    writeln('Daftar Tugas:');
    writeln('========================================');
    for i := 1 to taskCount do
    begin
      writeln('ID: ', tasks[i].id:3, ' | Nama: ', tasks[i].name, ' | Status: ', tasks[i].status);
    end;
    writeln('========================================');
  end;
end;

//Untuk mengubah status tugas
procedure UpdateTaskStatus(var tasks: array of Task; taskCount: integer);
var
  taskId: integer;
  choice: integer;
begin
  if taskCount = 0 then
    writeln('Belum ada tugas untuk diubah.')
  else
  begin
    write('Masukkan ID tugas yang ingin diubah statusnya: ');
    readln(taskId);

    if (taskId < 1) or (taskId > taskCount) then
    begin
      writeln('ID tugas tidak valid.');
      exit;
    end;

    writeln('Pilih status baru:');
    writeln('1. Selesai');
    writeln('2. Belum selesai');
    write('Pilihan Anda: ');
    readln(choice);

    case choice of
      1: tasks[taskId].status := 'Selesai';
      2: tasks[taskId].status := 'Belum selesai';
    else
      writeln('Pilihan tidak valid. Status tidak diubah.');
    end;

    writeln('Status tugas berhasil diperbarui!');
  end;
end;

//Untuk menampilkan menu dan mengembalikan pilihan
function ShowMenu: integer;
begin
  writeln('==========================');
  writeln('Task Management ');
  writeln('==========================');
  writeln('1. Tambah Tugas');
  writeln('2. Tampilkan Tugas');
  writeln('3. Ubah Status Tugas');
  writeln('4. Keluar');
  writeln('==========================');
  write('Pilih menu: ');
  readln(ShowMenu);
end;

//Untuk membersihkan layar sebelum menampilkan menu
procedure ClearScreen;
begin
  clrscr;
end;

//Program Utama
var
  choice: integer;
begin
  taskCount := 0;

  repeat
    ClearScreen;
    choice := ShowMenu;

    case choice of
      1: AddTask(tasks, taskCount);
      2: DisplayTasks(tasks, taskCount);
      3: UpdateTaskStatus(tasks, taskCount);
      4: writeln('Keluar dari program. Terima kasih!');
    else
      writeln('Pilihan tidak valid. Silakan coba lagi.');
    end;

    writeln; //Baris kosong untuk pemisah
    if choice <> 4 then
    begin
      writeln('Tekan Enter untuk melanjutkan...');
      readln;
    end;
  until choice = 4;
end.
