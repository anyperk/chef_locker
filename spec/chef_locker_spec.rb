require 'fileutils'
require 'securerandom'

require 'chef_locker'

RSpec.describe ChefLocker do
  let(:output) { StringIO.new }
  subject(:locker) { ChefLocker.new(output: output) }

  describe '#lock' do
    context 'when the given message is empty' do
      it 'raises ArgumentError' do
        expect { locker.lock }.to raise_error(ArgumentError)
      end
    end

    context 'when the given message is not blank' do
      let(:lockfile) { "spec/lockfiles/#{SecureRandom.hex}.pid" }

      before do
        allow(Chef::Config).to receive(:lockfile).and_return(lockfile)
        allow(locker).to receive(:loop)
      end

      after do
        FileUtils.rm_f(lockfile)
      end

      it 'acquires the lock' do
        reached = false
        allow(locker).to receive(:loop) do
          File.open(lockfile, 'r') do |f|
            expect(f.flock(File::LOCK_NB | File::LOCK_EX)).to eq(false)
            reached = true
          end
        end

        locker.lock('test')
        expect(reached).to eq(true)
      end

      it 'saves the PID and message in the lock file' do
        message = SecureRandom.hex
        locker.lock(message)

        expect(IO.read(lockfile)).to eq("#{$$} #{message}")
      end

      it 'blocks' do
        allow(locker).to receive(:loop).and_yield
        expect($stdin).to receive(:read)

        locker.lock('test')
      end

      it 'releases the lock' do
        locker.lock('test')

        File.open(lockfile, 'r') do |f|
          expect(f.flock(File::LOCK_NB | File::LOCK_EX)).to eq(0)
        end
      end
    end
  end
end
