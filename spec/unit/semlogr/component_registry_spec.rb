require 'semlogr/component_registry'

module Semlogr
  describe ComponentRegistry do
    class TypeA
    end

    class TypeB
      attr_reader :param

      def initialize(param = nil)
        @param = param
      end
    end

    describe '.register' do
      context 'when registering a new type' do
        it 'registers the type mapping' do
          ComponentRegistry.register(:sink, console: TypeA)

          resolved = ComponentRegistry.resolve(:sink, :console)

          expect(resolved).to be_a(TypeA)
        end
      end

      context 'when registering an already registered type' do
        before do
          ComponentRegistry.register(:sink, console: TypeA)
        end

        it 'overrides the existing mapping' do
          ComponentRegistry.register(:sink, console: TypeB)

          resolved = ComponentRegistry.resolve(:sink, :console)

          expect(resolved).to be_a(TypeB)
        end
      end
    end

    describe '.resolve' do
      context 'when resolving without params' do
        before do
          ComponentRegistry.register(:sink, console: TypeA)
        end

        it 'creates new instance of registered type' do
          resolved = ComponentRegistry.resolve(:sink, :console)

          expect(resolved).to be_a(TypeA)
        end
      end

      context 'when resolving with params' do
        before do
          ComponentRegistry.register(:sink, console: TypeB)
        end

        it 'creates new instance of registered type using params' do
          resolved = ComponentRegistry.resolve(:sink, :console, 123)

          expect(resolved).to be_a(TypeB)
          expect(resolved.param).to eq(123)
        end
      end
    end
  end
end
